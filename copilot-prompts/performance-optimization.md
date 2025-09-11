# 性能优化提示词

## 提示词类别

- [ ] 代码生成
- [x] 代码优化
- [ ] 代码解释
- [ ] 测试生成
- [ ] 文档生成
- [x] 代码重构

## 应用场景

用于识别和优化代码性能瓶颈，包括算法优化、内存管理、并发处理和资源使用优化。

## 提示词内容

### 1. 算法性能优化

```javascript
// 优化以下代码的性能
// 当前复杂度：${时间复杂度和空间复杂度}
// 性能问题：${具体的性能瓶颈}
// 数据规模：${预期处理的数据量}
// 优化目标：${目标复杂度或性能指标}
// 约束条件：${内存限制/兼容性要求等}

${需要优化的代码}
```javascript

### 2. 前端性能优化

```javascript
// 优化以下前端代码的性能
// 问题类型：${渲染慢/内存泄漏/包体积大/首屏加载慢}
// 目标指标：${LCP/FID/CLS等Core Web Vitals}
// 技术栈：${React/Vue/原生JS等}
// 优化方向：${代码分割/懒加载/缓存/压缩等}

${前端代码}
```javascript

### 3. 后端性能优化

```javascript
// 优化后端服务性能
// 性能瓶颈：${CPU密集/IO密集/内存使用/数据库查询}
// 并发需求：${QPS要求和并发用户数}
// 资源限制：${内存/CPU/网络带宽限制}
// 优化策略：${缓存/连接池/异步处理/负载均衡}

${后端代码}
```javascript

## 示例输入

```javascript
// 优化以下代码的性能
// 当前复杂度：O(n²) 时间复杂度，O(1) 空间复杂度
// 性能问题：数据量大时执行时间过长
// 数据规模：10万到100万条记录
// 优化目标：降低到 O(n log n) 或更好
// 约束条件：内存使用不能超过原来的10倍

function findDuplicates(arr) {
    const duplicates = [];
    
    for (let i = 0; i < arr.length; i++) {
        for (let j = i + 1; j < arr.length; j++) {
            if (arr[i] === arr[j] && !duplicates.includes(arr[i])) {
                duplicates.push(arr[i]);
            }
        }
    }
    
    return duplicates;
}

// 使用场景
const largeArray = generateLargeArray(500000);
const result = findDuplicates(largeArray);
```javascript

## 预期输出

```javascript
// 优化后的解决方案

/**
 * 高性能查找重复元素
 * 时间复杂度：O(n)
 * 空间复杂度：O(k) - k为唯一元素数量
 */
function findDuplicatesOptimized(arr) {
    const seen = new Map();  // 记录元素出现次数
    const duplicates = new Set();  // 使用Set避免重复添加
    
    // 单次遍历，记录出现次数
    for (const item of arr) {
        const count = seen.get(item) || 0;
        seen.set(item, count + 1);
        
        // 第二次遇到时才加入duplicates
        if (count === 1) {
            duplicates.add(item);
        }
    }
    
    return Array.from(duplicates);
}

/**
 * 内存优化版本：适用于数值数组且范围已知的情况
 * 时间复杂度：O(n)
 * 空间复杂度：O(1) - 原地标记
 */
function findDuplicatesInPlace(arr) {
    const duplicates = [];
    
    // 假设数组元素都是正整数且 <= arr.length
    for (let i = 0; i < arr.length; i++) {
        const index = Math.abs(arr[i]) - 1;
        
        if (index < arr.length) {
            if (arr[index] < 0) {
                // 已经标记过，说明是重复元素
                if (!duplicates.includes(Math.abs(arr[i]))) {
                    duplicates.push(Math.abs(arr[i]));
                }
            } else {
                // 第一次遇到，标记为负数
                arr[index] = -arr[index];
            }
        }
    }
    
    // 恢复原数组（可选）
    for (let i = 0; i < arr.length; i++) {
        arr[i] = Math.abs(arr[i]);
    }
    
    return duplicates;
}

/**
 * 流式处理版本：适用于超大数据集
 * 使用生成器减少内存占用
 */
function* findDuplicatesStream(iterable, maxMemory = 10000) {
    const seen = new Map();
    const duplicates = new Set();
    let processedCount = 0;
    
    for (const item of iterable) {
        const count = seen.get(item) || 0;
        seen.set(item, count + 1);
        
        if (count === 1 && !duplicates.has(item)) {
            duplicates.add(item);
            yield item;  // 立即返回找到的重复项
        }
        
        processedCount++;
        
        // 定期清理内存，保持在限制内
        if (processedCount % maxMemory === 0) {
            // 清理只出现一次的元素
            for (const [key, value] of seen.entries()) {
                if (value === 1 && !duplicates.has(key)) {
                    seen.delete(key);
                }
            }
        }
    }
}

/**
 * 并行处理版本：适用于多核环境
 * 使用 Worker 进行并行计算
 */
async function findDuplicatesParallel(arr, workerCount = 4) {
    const chunkSize = Math.ceil(arr.length / workerCount);
    const chunks = [];
    
    // 分割数组
    for (let i = 0; i < arr.length; i += chunkSize) {
        chunks.push(arr.slice(i, i + chunkSize));
    }
    
    // 创建 Worker 任务
    const workerPromises = chunks.map((chunk, index) => {
        return new Promise((resolve, reject) => {
            const worker = new Worker('./duplicate-worker.js');
            
            worker.postMessage({ chunk, originalArray: arr });
            
            worker.onmessage = (e) => {
                resolve(e.data.duplicates);
                worker.terminate();
            };
            
            worker.onerror = reject;
        });
    });
    
    // 等待所有 Worker 完成
    const results = await Promise.all(workerPromises);
    
    // 合并结果并去重
    const allDuplicates = new Set();
    results.forEach(duplicates => {
        duplicates.forEach(item => allDuplicates.add(item));
    });
    
    return Array.from(allDuplicates);
}

// 性能测试和比较
function performanceTest() {
    const testSizes = [1000, 10000, 100000];
    
    testSizes.forEach(size => {
        console.log(`\n测试数组大小: ${size}`);
        
        // 生成测试数据（包含约10%重复元素）
        const testArray = generateTestArray(size, size * 0.9);
        
        // 测试原始方法
        console.time(`原始方法-${size}`);
        const result1 = findDuplicates([...testArray]);
        console.timeEnd(`原始方法-${size}`);
        
        // 测试优化方法
        console.time(`优化方法-${size}`);
        const result2 = findDuplicatesOptimized([...testArray]);
        console.timeEnd(`优化方法-${size}`);
        
        // 验证结果一致性
        console.log(`结果一致: ${JSON.stringify(result1.sort()) === JSON.stringify(result2.sort())}`);
        
        // 内存使用情况
        if (performance.memory) {
            console.log(`内存使用: ${(performance.memory.usedJSHeapSize / 1024 / 1024).toFixed(2)} MB`);
        }
    });
}

// 辅助函数：生成测试数组
function generateTestArray(size, uniqueCount) {
    const unique = Array.from({ length: uniqueCount }, (_, i) => i);
    const array = [...unique];
    
    // 添加重复元素
    while (array.length < size) {
        array.push(unique[Math.floor(Math.random() * uniqueCount)]);
    }
    
    // 随机打乱
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    
    return array;
}

// Web Worker 代码 (duplicate-worker.js)
/*
self.onmessage = function(e) {
    const { chunk, originalArray } = e.data;
    const duplicates = [];
    const seen = new Set();
    
    // 检查chunk中的元素是否在原数组中重复
    chunk.forEach(item => {
        if (!seen.has(item)) {
            const firstIndex = originalArray.indexOf(item);
            const lastIndex = originalArray.lastIndexOf(item);
            
            if (firstIndex !== lastIndex) {
                duplicates.push(item);
            }
            seen.add(item);
        }
    });
    
    self.postMessage({ duplicates });
};
*/

// 使用示例和性能对比
console.log('开始性能测试...');
performanceTest();

// 实际使用
const largeArray = generateTestArray(500000, 450000);
console.log('\n处理50万条数据...');

console.time('优化版本');
const optimizedResult = findDuplicatesOptimized(largeArray);
console.timeEnd('优化版本');

console.log(`找到 ${optimizedResult.length} 个重复元素`);
```javascript

## 使用技巧

- 明确性能瓶颈的具体类型（CPU/内存/IO等）
- 提供具体的性能目标和约束条件
- 考虑不同数据规模下的表现
- 包含性能测试和对比验证
- 权衡时间复杂度和空间复杂度

## 效果评估

**准确性**: ⭐⭐⭐⭐⭐  
**实用性**: ⭐⭐⭐⭐⭐  
**创新性**: ⭐⭐⭐⭐⭐  

## 相关链接

- [[algorithm-optimization]]
- [[database-queries]]
- [[debugging-prompts]]

---
*Created: 2024-01-20*  
*Tags: #copilot-prompt #performance #optimization #algorithms*
